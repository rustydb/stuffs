#!/usr/bin/env ruby

=begin
OMP Testing Tool

Written by Russell Bunch (rbunch) Feb. 2015
=end

=begin

The Subshell is responsible for all shell interaction

When initialized it will check the host machine running it for the required `modules` command. Once this check
passes we grab the gems (libraries) we need. Then we grab the currently loaded environment and save it in
'original_compiler. Finally we end by opening our Bash subshell environment with 'open_bash'

'open_bash' initializes all of our system streams inside of a hash called 'bash_handle' sets stdin and stdout to flush
immediately after each use.

TODO: Explain talk_bash

There are several helper methods that are each commented individually.

=end

class Subshell

  attr_accessor :environment, :original_prg_env, :previous_prg_env, :subshell_handle, :fm

  # When initialized we want to double check that the host can access Cray modules, else abort
  def initialize
    self.environment = `env 2>&1`
    abort "ERROR: 'module' is not set in environment!\n\tCannot continue, aborting." unless environment.include? "module=()"

    require 'expect'
    require 'open3'

    open_subshell
    self.original_prg_env = which_prg_env?
    clean
    self.fm = FileManager.new
  end

  def clean
    Dir['*.o'].each do |file|
      File.delete file
    end
  end

  def open_subshell
    self.subshell_handle                              = {}
    subshell_handle[:stdin], subshell_handle[:stdout] = Open3.popen3(`which bash`)
    subshell_handle[:stdin].sync                      = true
    subshell_handle[:stdout].sync                     = true
  end

  def talk_to_subshell(command)
    subshell_handle[:stdin].puts command
    subshell_handle[:stdin].puts "echo '----'"
    subshell_handle[:stdout].expect('----', 5)
  end

  # OPTIMIZE remove regex in split
  def which_prg_env?
    modules = talk_to_subshell('module list 2>&1')
    modules[0].each_line do |line|
      return line.split(/\s+/)[2] if line.include? "PrgEnv"
    end
  end

  def set_gnu_env
    self.previous_prg_env = which_prg_env?
    talk_to_subshell("module swap #{previous_prg_env} PrgEnv-gnu")
  end

  def set_cce_env
    self.previous_prg_env = which_prg_env?
    talk_to_subshell("module swap #{previous_prg_env} PrgEnv-cray")
  end

  def compile

    set_gnu_env

    fm.files.each do |lang, types|
      types[:source_files].each do |file|
        output                         = talk_to_subshell("gcc -c #{file} 2>&1")
        types[:compile_failures][file] = output if did_fail?(output)
      end
      puts "Compile failures for #{lang}: #{types[:compile_failures].length} out of #{types[:source_files].length}"
      # FIXME Don't grab all .o files
      types[:compiled] = Dir['*.o']
    end
  end

  def link

    set_cce_env

    fm.files.each do |lang, types|
      types[:compiled].each do |file|
        output                      = talk_to_subshell("gcc -o #{file}ut #{file} 2>&1")
        types[:link_failures][file] = output if did_fail?(output)
      end
      puts "Link failures for #{lang}: #{types[:link_failures].length} out of #{types[:compiled].length}"
      # FIXME Don't grab all .o files
      types[:linked] = Dir['*.out']
    end
  end

  def did_fail?(output)
    output.each do |line|
      if line.downcase.include? "error"
        return true
      end
    end
    false
  end
end

class FileManager

  attr_accessor :files

  def initialize
    self.files  = {}
    files[:f90] = {
        :source_files     => Dir['*.f90'],
        :compile_failures => {},
        :compiled         => {},
        :link_failures    => {},
        :linked           => {}
    }
    files[:c]   = {
        :source_files     => Dir['*.c'],
        :compile_failures => {},
        :compiled         => {},
        :link_failures    => {},
        :linked           => {}
    }
    files[:cpp] = {
        :source_files     => Dir['*.cpp'],
        :compile_failures => {},
        :compiled         => {},
        :link_failures    => {},
        :linked           => {}
    }
  end
end

subshell = Subshell.new
subshell.compile
subshell.link

