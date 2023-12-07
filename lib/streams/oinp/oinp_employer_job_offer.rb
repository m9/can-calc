require 'tty-prompt'
require 'colorize'

module OINP
  class EmployerJobOffer
    def initialize
      @prompt = TTY::Prompt.new
      @score = 0

      calculate_employment_factors
      print_score

    end

    private

    def calculate_employment_factors
      puts '[ Employment / labour market factors ]'.light_blue
      @score += @prompt.select('Job offer: NOC TEER category', cycle: true) do |m|
        m.enum '.'

        m.choice 'NOC TEER 0 or 1', 10
        m.choice 'NOC TEER 2 or 3', 8
        m.choice 'NOC TEER 4'     , 0
        m.choice 'NOC TEER 5'     , 0
      end

      @score += @prompt.select('Job offer: NOC broad occupational category', cycle: true) do |m|
        m.enum '.'

        m.choice 'Occupational Category 0, 2, 3', 10
        m.choice 'Occupational Category 7'      , 7
        m.choice 'Occupational Category 1, 9'   , 5
        m.choice 'Occupational Category 4, 8'   , 4
        m.choice 'Occupational Category 5, 6'   , 3
      end

      @score += @prompt.select('Job offer: wage', cycle: true) do |m|
        m.enum '.'

        m.choice '$40 per hour or higher ', 10
        m.choice '$35 to $39.99 per hour ', 8
        m.choice '$30 to $34.99 per hour ', 7
        m.choice '$25 to $29.99 per hour ', 6
        m.choice '$20 to $24.99 per hour ', 5
        m.choice 'Less than $20 per hour ', 0
      end

      @score += @prompt.select('Work permit status', cycle: true) do |m|
        m.enum '.'

        m.choice 'WITH valid work permit ', 10
        m.choice 'WITHOUT valid work permit ', 0
      end

      @score += @prompt.select('Job tenure with job offer employer', cycle: true) do |m|
        m.enum '.'

        m.choice '6 months or more working in job offer position', 3
        m.choice 'Less than 6 months working in job offer position or not currently working in position', 0
      end

      @score += @prompt.select("Earnings history based on a NoA issued by the CRA in the last five years", cycle: true) do |m|
        m.enum '.'

        m.choice '$40k or more a year', 3
        m.choice 'Less than $40k in a year', 0
      end

      puts
      puts '[ Language ]'.light_blue

      @score += @prompt.select('Official language ability', cycle: true) do |m|
        m.enum '.'

        m.choice 'CLB 9 or higher', 10
        m.choice 'CLB 8', 6
        m.choice 'CLB 7', 4
        m.choice 'CLB 6 or lower', 0
      end

      @score += @prompt.select('Knowledge of official languages', cycle: true) do |m|
        m.enum '.'

        m.choice '1 Official Language', 0
        m.choice '2 Official Languages', 10
      end

      puts
      puts '[ Regionalization ]'.light_blue

      @score += @prompt.select('Regional immigration: location of job offer', cycle: true) do |m|
        m.enum '.'

        m.choice 'Toronto', 0
        m.choice 'Inside GTA', 3
        m.choice 'Other areas outside GTA (except Northern Ontario)', 8
        m.choice 'Northern Ontario', 10
      end

      # @score += @prompt.select('', cycle: true) do |m|
      #   m.enum '.'
      #
      #   m.choice '', 0
      # end

    end

    def print_score
      puts
      puts "Your score is: #{@score}"
    end
  end
end